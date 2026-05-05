pragma Singleton

import "root:/utils"
import "root:/utils/scripts/fuzzysort.js" as Fuzzy
import Quickshell

Singleton {
  id: root

  readonly property list<DesktopEntry> list: DesktopEntries.applications.values.filter(entry => !entry.noDisplay).sort((a, b) => a.name.localeCompare(b.name))
  readonly property list<var> preppedApps: list.map(entry => ({
      name: Fuzzy.prepare(entry.name),
      comment: Fuzzy.prepare(entry.comment),
      entry
  }))

  function fuzzyQuery(search: string, max: int, filter: var, terminal: string, favorites: var): var {
    let preparedApps = root.preppedApps

    if (filter) {
      preparedApps = preparedApps.filter(e => filter(e.entry))
    }

    let matches = Fuzzy.go(search, preparedApps, {
      all: true,
      keys: ["name", "comment"],
      scoreFn: r => {
        if (r[0].score <= 0) return 0
        const base = r[0].score * 0.9 + r[1].score * 0.1
        // logarithmic usage boost so frequent apps rise without drowning exact matches
        return base + Math.log(1 + UsageTracker.getScore(r.obj.entry.id)) * 0.05
      }
    })

    let res = matches.map(r => r.obj.entry);

    if (favorites) {
      res.sort((a, b) => {
        const aFav = favorites.indexOf(a.id) !== -1
        const bFav = favorites.indexOf(b.id) !== -1
        if (aFav !== bFav) return aFav ? -1 : 1
        return UsageTracker.getScore(b.id) - UsageTracker.getScore(a.id)
      })
    }

    // Add Calculate fallback if solvable
    const calcResult = CalculationService.calculate(search);
    if (calcResult !== null) {
      res.unshift({
        name: `= ${calcResult}`,
        comment: "calculate",
        icon: `${Paths.assets}/calculator-icon.svg`,
        execute: () => {
          CalculationService.copyToClipboard(calcResult);
        }
      });
    }

    res.push({
      name: search,
      comment: "run in terminal",
      icon: `${Paths.assets}/terminal-icon.svg`,
      execute: () => {
        CommandService.runInTerminal(search, terminal)
        window.realVisible = false
      }
    })

    if (max && res.length > max) {
      res = res.slice(0, max);
    }

    return res
  }
}

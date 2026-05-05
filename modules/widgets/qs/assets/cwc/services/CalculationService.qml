pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  // Used for internal calculations and clipboard operations
  Process {
    id: calcProcess
    running: false
  }

  Process {
    id: copyProcess
    running: false
  }

  function calculate(expression) {
    // We use bc -l for floating point calculations
    // We use a synchronous-like approach by running it via a shell and capturing output
    // Since QML Process is async, we might need a different way to get the result for the search list.
    // However, for the 'comment' field in fuzzyQuery, we need an immediate value.
    // Since we can't easily do sync process calls in QML, we'll use a small JS eval for the 'preview'
    // and the real 'bc' for the final execution if preferred, or just JS eval for both if it's safe enough
    // given it's just for a local launcher.

    try {
      // Sanitize expression to allow only math characters
      const sanitized = expression.replace(/[^0-9+\-*/.() ]/g, '');
      if (sanitized !== expression) return null;

      // Use JS eval for the immediate preview result
      const result = eval(sanitized);
      return (result !== undefined && !isNaN(result)) ? result.toString() : null;
    } catch (e) {
      return null;
    }
  }

  function copyToClipboard(text) {
    copyProcess.command = ["wl-copy", text];
    copyProcess.running = true;
  }
}

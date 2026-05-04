const entry = App.configDir + '/scripts/index.ts'
const outdir = '/home/careem/.cache/ags/js'

try {
  await Utils.execAsync(['bun', 'build', entry, '--outdir', outdir, '--external', 'resource://*', '--external', 'gi://*'])

  await import(`file://${outdir}/index.js`)
} catch (error) {
  console.error(error)
}

export {}

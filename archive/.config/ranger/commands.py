import os.path
from ranger.api.commands import Command
from ranger.core.loader import CommandLoader

class yankImage(Command):
    def execute(self):
        if self.arg(1):
            self.fm.notify('Wrong number of arguments', bad=True)
            return
        
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        # Get filenames
        filenames = [os.path.relpath(f.path, cwd.path) for f in marked_files]
        
        self.fm.execute_command('wl-copy < ' + filenames[0])

class pasteImage(Command):
    def execute(self):
        if self.arg(1):
            name = self.arg(1)
            self.fm.notify(f'wl-paste -t image > {name}')
            self.fm.execute_command(f'wl-paste -t image > {name}')
        else:
            cwd = self.fm.thisdir
            name = 'pasted_image'

            self.fm.notify(cwd.path)

            i = 1
            while os.path.isfile(cwd.path + '/' + name):
                name = f'pasted_image_{i}'
                i += 1
            
            self.fm.execute_command(f'wl-paste -t image > {name}.jpg')

class pi(pasteImage):
    pass

from swift_types import *

@wrapper(py_init=False)
class PHPickerResults:

    def __getitem__(self) -> object: ...

@wrapper
class PHPicker:

    class Callbacks:
        def picker_didFinishPicking(self, results: object): ...

    def open(self, limit: int): ...

    def dismiss(self): ...

    #def test(url: URL, err: Error): ...

    
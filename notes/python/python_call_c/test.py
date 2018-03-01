from ctypes import cdll
mod = cdll.LoadLibrary("mod.so")
print mod.func(1)

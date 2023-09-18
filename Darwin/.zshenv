# Explicit environment variables for macOS
export DEVELOPER_FOLDER=${HOME}/Developer

# To use the bundled libc++ please add the following LDFLAGS:
#  LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
# For compilers to find llvm you may need to set:
#  export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
#  export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
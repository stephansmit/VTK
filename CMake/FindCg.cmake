#
# Try to find nVidia's Cg compiler, runtime libraries, and include path.
#
# CG_INCLUDE_PATH = directory where cg.h resides
# CG_LIBRARY = full path to libCg.so (Cg.DLL on win32)
# CG_GL_LIBRARY = full path to libCgGL.so (CgGL.dll on win32)
# CG_COMPILER = full path to cgc (cgc.exe on win32)
#

IF (WIN32)
FIND_PROGRAM( CG_COMPILER cgc
  "C:/Program Files/NVIDIA Corporation/Cg/bin"
  "C:/Program Files/Cg"
  ${PROJECT_SOURCE_DIR}/../Cg
  DOC "The Cg Compiler"
)
IF (CG_COMPILER)
  GET_FILENAME_COMPONENT(CG_COMPILER_DIR ${CG_COMPILER} PATH)
  GET_FILENAME_COMPONENT(CG_COMPILER_SUPER_DIR ${CG_COMPILER_DIR} PATH)
ELSE (CG_COMPILER)
  SET (CG_COMPILER_DIR .)
  SET (CG_COMPILER_SUPER_DIR ..)
ENDIF (CG_COMPILER)
FIND_PATH( CG_INCLUDE_PATH Cg/cg.h
  "C:/Program Files/NVIDIA Corporation/Cg/include"
  "C:/Program Files/Cg"
  ${PROJECT_SOURCE_DIR}/../Cg
  ${CG_COMPILER_SUPER_DIR}/include
  ${CG_COMPILER_DIR}
  DOC "The directory where Cg/cg.h resides"
)
FIND_LIBRARY( CG_LIBRARY
  NAMES Cg
  PATHS
    "C:/Program Files/NVIDIA Corporation/Cg/lib"
    "C:/Program Files/Cg"
    ${PROJECT_SOURCE_DIR}/../Cg
    ${CG_COMPILER_SUPER_DIR}/lib
    ${CG_COMPILER_DIR}
  DOC "The Cg runtime library"
)
FIND_LIBRARY( CG_GL_LIBRARY
  NAMES CgGL
  PATHS
    "C:/Program Files/NVIDIA Corporation/Cg/lib"
    "C:/Program Files/Cg"
    ${PROJECT_SOURCE_DIR}/../Cg
    ${CG_COMPILER_SUPER_DIR}/lib
    ${CG_COMPILER_DIR}
  DOC "The Cg runtime library"
)
ELSE (WIN32)
FIND_PROGRAM( CG_COMPILER cgc
  /usr/bin
  /usr/local/bin
  DOC "The Cg Compiler"
)
GET_FILENAME_COMPONENT(CG_COMPILER_DIR "${CG_COMPILER}" PATH)
GET_FILENAME_COMPONENT(CG_COMPILER_SUPER_DIR "${CG_COMPILER_DIR}" PATH)
FIND_PATH( CG_INCLUDE_PATH Cg/cg.h
  /usr/include
  /usr/local/include
  ${CG_COMPILER_SUPER_DIR}/include
  DOC "The directory where Cg/cg.h resides"
)
FIND_LIBRARY( CG_LIBRARY Cg
  PATHS
    /usr/lib64
    /usr/lib
    /usr/local/lib64
    /usr/local/lib
    ${CG_COMPILER_SUPER_DIR}/lib64
    ${CG_COMPILER_SUPER_DIR}/lib
  DOC "The Cg runtime library"
)
FIND_LIBRARY( CG_GL_LIBRARY CgGL
  PATHS
    /usr/lib64
    /usr/lib
    /usr/local/lib64
    /usr/local/lib
    ${CG_COMPILER_SUPER_DIR}/lib64
    ${CG_COMPILER_SUPER_DIR}/lib
  DOC "The Cg runtime library"
)
ENDIF (WIN32)

IF (CG_INCLUDE_PATH)
SET( FOUND_CG 1 CACHE STRING "Set to 1 if CG is found, 0 otherwise")
ELSE (CG_INCLUDE_PATH)
SET( FOUND_CG 0 CACHE STRING "Set to 1 if CG is found, 0 otherwise")
ENDIF (CG_INCLUDE_PATH)

MARK_AS_ADVANCED( FOUND_CG )

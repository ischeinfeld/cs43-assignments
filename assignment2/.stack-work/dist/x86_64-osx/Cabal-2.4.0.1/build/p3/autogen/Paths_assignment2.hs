{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_assignment2 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/ischeinfeld/Documents/cs43/cs43-assignments/assignment2/.stack-work/install/x86_64-osx/000540cc02a5e9c2215c3329ac80917ac23967f0cb32fc6e96bd558083691c19/8.6.5/bin"
libdir     = "/Users/ischeinfeld/Documents/cs43/cs43-assignments/assignment2/.stack-work/install/x86_64-osx/000540cc02a5e9c2215c3329ac80917ac23967f0cb32fc6e96bd558083691c19/8.6.5/lib/x86_64-osx-ghc-8.6.5/assignment2-0.1.0.0-9AdBh72dAIP1mxnZfmOPwJ-p3"
dynlibdir  = "/Users/ischeinfeld/Documents/cs43/cs43-assignments/assignment2/.stack-work/install/x86_64-osx/000540cc02a5e9c2215c3329ac80917ac23967f0cb32fc6e96bd558083691c19/8.6.5/lib/x86_64-osx-ghc-8.6.5"
datadir    = "/Users/ischeinfeld/Documents/cs43/cs43-assignments/assignment2/.stack-work/install/x86_64-osx/000540cc02a5e9c2215c3329ac80917ac23967f0cb32fc6e96bd558083691c19/8.6.5/share/x86_64-osx-ghc-8.6.5/assignment2-0.1.0.0"
libexecdir = "/Users/ischeinfeld/Documents/cs43/cs43-assignments/assignment2/.stack-work/install/x86_64-osx/000540cc02a5e9c2215c3329ac80917ac23967f0cb32fc6e96bd558083691c19/8.6.5/libexec/x86_64-osx-ghc-8.6.5/assignment2-0.1.0.0"
sysconfdir = "/Users/ischeinfeld/Documents/cs43/cs43-assignments/assignment2/.stack-work/install/x86_64-osx/000540cc02a5e9c2215c3329ac80917ac23967f0cb32fc6e96bd558083691c19/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "assignment2_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "assignment2_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "assignment2_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "assignment2_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "assignment2_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "assignment2_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)

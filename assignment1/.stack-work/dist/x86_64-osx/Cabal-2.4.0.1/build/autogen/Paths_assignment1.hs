{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_assignment1 (
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

bindir     = "/Users/ischeinfeld/Documents/cs43/stanford-lambda.gitlab.io/starter-code/assignment1/.stack-work/install/x86_64-osx/208877588e53e0361813e3085cb95398a5e43368b04bd92a054aa0ab80630962/8.6.5/bin"
libdir     = "/Users/ischeinfeld/Documents/cs43/stanford-lambda.gitlab.io/starter-code/assignment1/.stack-work/install/x86_64-osx/208877588e53e0361813e3085cb95398a5e43368b04bd92a054aa0ab80630962/8.6.5/lib/x86_64-osx-ghc-8.6.5/assignment1-0.1.0.0-7z2NAWLKdlC84r2Cr7RJB4"
dynlibdir  = "/Users/ischeinfeld/Documents/cs43/stanford-lambda.gitlab.io/starter-code/assignment1/.stack-work/install/x86_64-osx/208877588e53e0361813e3085cb95398a5e43368b04bd92a054aa0ab80630962/8.6.5/lib/x86_64-osx-ghc-8.6.5"
datadir    = "/Users/ischeinfeld/Documents/cs43/stanford-lambda.gitlab.io/starter-code/assignment1/.stack-work/install/x86_64-osx/208877588e53e0361813e3085cb95398a5e43368b04bd92a054aa0ab80630962/8.6.5/share/x86_64-osx-ghc-8.6.5/assignment1-0.1.0.0"
libexecdir = "/Users/ischeinfeld/Documents/cs43/stanford-lambda.gitlab.io/starter-code/assignment1/.stack-work/install/x86_64-osx/208877588e53e0361813e3085cb95398a5e43368b04bd92a054aa0ab80630962/8.6.5/libexec/x86_64-osx-ghc-8.6.5/assignment1-0.1.0.0"
sysconfdir = "/Users/ischeinfeld/Documents/cs43/stanford-lambda.gitlab.io/starter-code/assignment1/.stack-work/install/x86_64-osx/208877588e53e0361813e3085cb95398a5e43368b04bd92a054aa0ab80630962/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "assignment1_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "assignment1_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "assignment1_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "assignment1_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "assignment1_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "assignment1_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)

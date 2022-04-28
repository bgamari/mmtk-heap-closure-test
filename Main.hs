{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE GHCForeignImportPrim #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE UnboxedTuples #-}
{-# LANGUAGE UnliftedFFITypes #-}
{-# LANGUAGE TypeInType #-}
{-# LANGUAGE RankNTypes #-}

module Main where

import GHC.Exts
import Unsafe.Coerce
import GHC.IO

foreign import prim "cmm_printClosure"
    cmm_printClosure :: Any -> (# #)

pap :: Int -> Int -> Int
pap x y = x+y

printClosure
    :: a -> IO ()       
printClosure x =
    IO (\s -> case cmm_printClosure (unsafeCoerce# x) of
                (# #) -> (# s, () #))

printClosureUnlifted
    :: forall (a :: TYPE UnliftedRep). a -> IO ()       
printClosureUnlifted x =
    IO (\s -> case cmm_printClosure (unsafeCoerce# x) of
                (# #) -> (# s, () #))

main :: IO ()
main = do
    printClosure (Just 42 :: Maybe Int)
    printClosure (id :: Int -> Int)
    printClosure (head [42,53] :: Int)
    printClosure (pap 42)
    IO (\s0# -> case newByteArray# 42# s0# of
                  (# s1#, ba# #) -> unIO (printClosureUnlifted ba#) s1#)


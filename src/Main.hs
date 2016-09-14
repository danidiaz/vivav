{-# language TypeApplications #-}
module Main where

import Control.Monad
import Control.Applicative
import Control.Lens
import Data.Aeson
import Network
import Pipes
import qualified Pipes.ByteString
import qualified Pipes.Aeson.Unchecked
import System.IO

main :: IO ()
main = do
    let portID = PortNumber 7777
    socket <- listenOn portID
    putStrLn $ "Listening on" ++ show portID
    forever $ do (handle,_,_) <- accept socket
                 putStrLn "Connection accepted."
                 hSetBuffering handle NoBuffering
                 let jsonStream = view Pipes.Aeson.Unchecked.decoded
                                       (Pipes.ByteString.fromHandle handle)
                 runEffect $ for jsonStream $ lift . print @Value
                 putStrLn "wee!"

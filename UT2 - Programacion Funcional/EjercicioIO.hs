readN::Int->IO [String]
readN 0 = return []
readN n = do
  line <- getLine
  lines <- readN (n-1)
  return (line:lines)

readMany::IO [String]
readMany = do
  line<-getLine
  if (line=="") then (return []) else do
    lineas <- readMany
    return (line:lineas)

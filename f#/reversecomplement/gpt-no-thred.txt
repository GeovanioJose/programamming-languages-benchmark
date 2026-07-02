open System

[<Literal>]
let PageSize = 1048576 // 1024 * 1024
let pages = Array.zeroCreate 2048
let mutable readCount, canWriteCount, lastPageSize = 0, 0, -1

let inputStream = Console.OpenStandardInput()

let rec readLoop () =
    let buffer = Array.zeroCreate PageSize
    let rec read offset count =
        let bytesRead = inputStream.Read(buffer, offset, count)
        if bytesRead = count then offset + count
        elif bytesRead = 0 then offset
        else read (offset + bytesRead) (count - bytesRead)
    let bytesRead = read 0 PageSize
    pages.[readCount] <- buffer
    readCount <- readCount + 1
    if bytesRead <> PageSize then lastPageSize <- bytesRead else readLoop()

readLoop()

let map = Array.init 256 byte
Array.iter2 (fun i v -> map.[int i] <- v)
    "ABCDGHKMRTVYabcdghkmrtvy"B
    "TVGHCDMKYABRTVGHCDMKYABR"B

let reverse startPage startIndex endPage endIndex =
    let mutable loPageID, lo = startPage, startIndex
    let mutable hiPageID, hi = endPage, endIndex
    while loPageID < hiPageID || (loPageID = hiPageID && lo <= hi) do
        let loPage = pages.[loPageID]
        let hiPage = pages.[hiPageID]
        let iValue = loPage.[lo]
        let jValue = hiPage.[hi]
        if iValue = '\n'B || jValue = '\n'B then
            if iValue = '\n'B then lo <- lo + 1
            if jValue = '\n'B then hi <- hi - 1
        else
            loPage.[lo] <- map.[int jValue]
            hiPage.[hi] <- map.[int iValue]
            lo <- lo + 1
            hi <- hi - 1
        if lo = PageSize then
            loPageID <- loPageID + 1
            lo <- 0
        if hi = -1 then
            hiPageID <- hiPageID - 1
            hi <- PageSize - 1

let rec reverseAll page i =
    let rec skipHeader page i =
        let i = Array.IndexOf(pages.[page], '\n'B, i, PageSize - i)
        if i <> -1 then page, i + 1 else skipHeader (page + 1) 0
    let loPageID, lo = skipHeader page i
    let rec findNextAndReverse pageID i =
        let onLastPage = pageID + 1 = readCount && lastPageSize <> -1
        let thisPageSize = if onLastPage then lastPageSize else PageSize
        let i = Array.IndexOf(pages.[pageID], '>'B, i, thisPageSize - i)
        if i <> -1 then
            reverse loPageID lo pageID (i - 1)
            reverseAll pageID i
        elif onLastPage then
            reverse loPageID lo pageID (lastPageSize - 1)
            canWriteCount <- readCount
        else findNextAndReverse (pageID + 1) 0

    findNextAndReverse loPageID lo

reverseAll 0 0

let outputStream = Console.OpenStandardOutput()

let rec writeLoop writtenCount =
    if writtenCount + 1 = readCount && lastPageSize <> -1 then
        outputStream.Write(pages.[writtenCount], 0, lastPageSize) |> ignore
    else
        outputStream.Write(pages.[writtenCount], 0, PageSize) |> ignore
        writeLoop (writtenCount + 1)

writeLoop 0

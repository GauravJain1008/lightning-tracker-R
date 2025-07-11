library(websocket)
library(ggplot2)
library(jsonlite)

template_df = data.frame(time = character(),
                         lat = character(),
                         lon = character(),
                         alt = character(),
                         pol = character(),
                         mds = character(),
                         status = character(),
                         region = character(),
                         delay = character(),
                         lonc = character(),
                         latc = character())

lzw_decompress <- function(code_str) {
  codes <- utf8ToInt(code_str)
  dict_size <- 256
  dictionary <- as.list(sapply(0:(dict_size - 1), intToUtf8))
  
  result <- character()
  prev_code <- codes[1]
  result <- c(result, dictionary[[prev_code + 1]])
  
  for (i in 2:length(codes)) {
    code <- codes[i]
    if (code < length(dictionary)) {
      entry <- dictionary[[code + 1]]
    } else if (code == dict_size) {
      entry <- paste0(dictionary[[prev_code + 1]], substring(dictionary[[prev_code + 1]], 1, 1))
    } else {
      stop(paste("Bad LZW code:", code))
    }
    
    result <- c(result, entry)
    
    dictionary[[dict_size + 1]] <- paste0(dictionary[[prev_code + 1]], substring(entry, 1, 1))
    dict_size <- dict_size + 1
    
    prev_code <- code
  }
  
  paste(result, collapse = "")
}


# Create websocket client
ws <- WebSocket$new("wss://ws7.blitzortung.org/", autoConnect = FALSE)

# On connection open: send subscription message
ws$onOpen(function(event) {
  cat("WebSocket connection opened. Sending subscription message...\n")
  ws$send('{"a":111}')  # Send the same message your browser sends
  

})

strike_counter = 1
# On message received
ws$onMessage(function(event) {
  
  # Decompress using LZW function
  decompressed <- tryCatch({
    lzw_decompress(event$data)
  }, error = function(e) {
    paste("Decompression error:", e$message)
  })
  
  print(paste0("strike collected: ", strike_counter))
  strike_counter = strike_counter + 1
  assign("strike_counter",strike_counter,.GlobalEnv)
  
  x = fromJSON(decompressed)
  x = x[names(x) != "sig"]
  x = data.frame(x)
  
  # template_df = get("template_df", envir = .GlobalEnv)
  template_df = rbind(template_df, x)
  
  assign("template_df",template_df,.GlobalEnv)
  
})


# On error
ws$onError(function(event) {
  cat("Error:", event$message, "\n")
})

# On close
ws$onClose(function(event) {
  cat("WebSocket closed\n")
})

# Connect and start the event loop
ws$connect()


# DON'T RUN THIS LINE UNTIL YOU WANT TO STOP COLLECTING
#ws$close()

timestamp_ns <- as.numeric(template_df$time)
timestamp_sec <- timestamp_ns / 1e9
template_df$time = as.POSIXct(timestamp_sec, origin = "1970-01-01", tz = "UTC")



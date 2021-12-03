get_citation_yr_range = function(cf, df) {
  
  r = c()
  s = c()
  e = c()
  
  for (i in 1:nrow(cf)) { 
    yrs = unlist(cf[i,15:length(cf)])
    
    if (sum(yrs) == 0) {
      range = ""
      r = c(r, range)
      s = c(s, range)
      e = c(e, range)
    }
    if (sum(yrs) > 0) {
      yrscited = which(yrs > 1)
      
      if (length(yrscited) == 0) {
        range = ""
        r = c(r, range)
        s = c(s, range)
        e = c(e, range)
      }
      if (length(yrscited) == 1) {
        range = names(yrscited)
        r = c(r, range)
        s = c(s, range)
        e = c(e, range)
      }
      if (length(yrscited) > 1) {
        all_yrs = (as.numeric(names(yrscited)))
        start_yr = min(all_yrs)
        end_yr = max(all_yrs)
        range = paste0(start_yr,"-", end_yr)
        r = c(r, range)
        s = c(s, start_yr)
        e = c(e, end_yr)
      }
    }
  }
  
  cf$YrRange = r
  cf$YrStart = s
  cf$YrEnd = e
  
  df$YrRange = r
  df$YrStart = s
  df$YrEnd = e
  
  return(list(cf,df))
}
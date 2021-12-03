t_col <- function(color, percent = 70, name = NULL) {
  rgb.val <- col2rgb(color)
  t.col <- rgb(rgb.val[1], rgb.val[2], rgb.val[3],
               max = 255,
               alpha = (100 - percent) * 255 / 100,
               names = name)
  invisible(t.col)
}

get_data_for_plotting = function(df) {
  dp = cbind(as.numeric(df$CiteT),
             as.numeric(df$YrStart), 
             as.numeric(df$YrEnd))
  dp = as.data.frame(dp)
  colnames(dp) = c("CiteT", "YrStart", "YrEnd")
  dp = dp[complete.cases(dp),]
  
  return(dp)
}

generate_citation_plot = function(dp){
  plot(1, type="n", xlab="Year", ylab="Total Number of Citations", 
       xlim=c(1920,1999), 
       ylim=c(0,610), 
       main="blue <=20 yr range | black = remaining")
  for (i in 1:nrow(dp)){
    if (dp$YrEnd[i]-dp$YrStart[i] <=20) {
      lines(c(dp$YrStart[i], dp$YrEnd[i]), c(dp$CiteT[i], dp$CiteT[i]), type="l", col="blue")
    }
    else {
      lines(c(dp$YrStart[i], dp$YrEnd[i]), c(dp$CiteT[i], dp$CiteT[i]), type="l", col=t_col("black"))}
  }
}

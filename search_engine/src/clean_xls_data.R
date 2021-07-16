library(dplyr)

# 1) Read XLS files

keep_cols = c("Title","Authors","Corporate Authors","Editors",
              "Book Editors","Source Title","Publication Date",
              "Publication Year","Volume","Issue","Part Number",
              "Supplement","Special Issue","Beginning Page",
              "Ending Page","Article Number","DOI","Conference Title",
              "Conference Date","Total Citations","Average per Year",
              "1900","1901","1902","1903","1904","1905","1906","1907",
              "1908","1909","1910","1911","1912","1913","1914","1915",
              "1916","1917","1918","1919","1920","1921","1922","1923",
              "1924","1925","1926","1927","1928","1929","1930","1931",
              "1932","1933","1934","1935","1936","1937","1938","1939",
              "1940","1941","1942","1943","1944","1945","1946","1947",
              "1948","1949","1950","1951","1952","1953","1954","1955",
              "1956","1957","1958","1959","1960","1961","1962","1963",
              "1964","1965","1966","1967","1968","1969","1970","1971",
              "1972","1973","1974","1975","1976","1977","1978","1979",
              "1980","1981","1982","1983","1984","1985","1986","1987",
              "1988","1989","1990","1991","1992","1993","1994","1995",
              "1996","1997","1998","1999")

clean_cite_data = function(d, cnames) {
  colnames(d) = cnames
  d = d[29:nrow(d),]
  return(d)
}

## datasets1

data1 <- read_excel("xls_exports/WCUSA-search-1.xls")
data2 <- read_excel("xls_exports/WCUSA-search-2.xls")

cite1 <- read_excel("xls_exports/WCUSA-cite-1.xls")
cite2 <- read_excel("xls_exports/WCUSA-cite-2.xls")

cite1 = clean_cite_data(cite1, keep_cols)
cite2 = clean_cite_data(cite2, keep_cols)

## datasets2

data1A <- read_excel("xls_exports/TS9J2-search-1.xls")
data2A <- read_excel("xls_exports/TS9J2-search-2.xls")
data3A <- read_excel("xls_exports/TS9J2-search-3.xls")

cite1A <- read_excel("xls_exports/TS9J2-cite-1.xls")
cite2A <- read_excel("xls_exports/TS9J2-cite-2.xls")
cite3A <- read_excel("xls_exports/TS9J2-cite-3.xls")

cite1A = clean_cite_data(cite1A, keep_cols)
cite2A = clean_cite_data(cite2A, keep_cols)
cite3A = clean_cite_data(cite3A, keep_cols)

## datasets3

data1B <- read_excel("xls_exports/BAJ2-search-1.xls")
data2B <- read_excel("xls_exports/BAJ2-search-2.xls")
data3B <- read_excel("xls_exports/BAJ2-search-3.xls")
data4B <- read_excel("xls_exports/BAJ2-search-4.xls")
data5B <- read_excel("xls_exports/BAJ2-search-5.xls")
data6B <- read_excel("xls_exports/BAJ2-search-6.xls")
data7B <- read_excel("xls_exports/BAJ2-search-7.xls")
data8B <- read_excel("xls_exports/BAJ2-search-8.xls")
data9B <- read_excel("xls_exports/BAJ2-search-9.xls")
data10B <- read_excel("xls_exports/BAJ2-search-10.xls")
data11B <- read_excel("xls_exports/BAJ2-search-11.xls")
data12B <- read_excel("xls_exports/BAJ2-search-12.xls")

cite1B <- read_excel("xls_exports/BAJ2-cite-1.xls")
cite2B <- read_excel("xls_exports/BAJ2-cite-2.xls")
cite3B <- read_excel("xls_exports/BAJ2-cite-3.xls")
cite4B <- read_excel("xls_exports/BAJ2-cite-4.xls")
cite5B <- read_excel("xls_exports/BAJ2-cite-5.xls")
cite6B <- read_excel("xls_exports/BAJ2-cite-6.xls")
cite7B <- read_excel("xls_exports/BAJ2-cite-7.xls")
cite8B <- read_excel("xls_exports/BAJ2-cite-8.xls")
cite9B <- read_excel("xls_exports/BAJ2-cite-9.xls")
cite10B <- read_excel("xls_exports/BAJ2-cite-10.xls")
cite11B <- read_excel("xls_exports/BAJ2-cite-11.xls")
cite12B <- read_excel("xls_exports/BAJ2-cite-12.xls")

cite1B = clean_cite_data(cite1B, keep_cols)
cite2B = clean_cite_data(cite2B, keep_cols)
cite3B = clean_cite_data(cite3B, keep_cols)
cite4B = clean_cite_data(cite4B, keep_cols)
cite5B = clean_cite_data(cite5B, keep_cols)
cite6B = clean_cite_data(cite6B, keep_cols)
cite7B = clean_cite_data(cite7B, keep_cols)
cite8B = clean_cite_data(cite8B, keep_cols)
cite9B = clean_cite_data(cite9B, keep_cols)
cite10B = clean_cite_data(cite10B, keep_cols)
cite11B = clean_cite_data(cite11B, keep_cols)
cite12B = clean_cite_data(cite12B, keep_cols)


## binding datasets1, datasets2, datasets3

dataWCUSA= rbind(data1, data2)
citesWCUSA = rbind(cite1, cite2)

dataTS9J2 = rbind(data1A,data2A,data3A)
dataBAJ2 = rbind(data1B,data2B,data3B,data4B,data5B,data6B,
                 data7B,data8B,data9B,data10B,data11B,data12B)

citesTS9J2 = rbind(cite1A,cite2A,cite3A)
citesBAJ2 = rbind(cite1B,cite2B,cite3B,cite4B,cite5B,cite6B,
                  cite7B,cite8B,cite9B,cite10B,cite11B,cite12B)

# 2) Remove unnecessary columns 

remove_cols = c("Book Authors", "Book Editors", "Book Group Authors", "Book Author Full Names", 
                "Group Authors", "Book Series Title", "Book Series Subtitle", "Book DOI", 
                "Conference Title", "Conference Date", "Conference Location", "Conference Sponsor",
                "Conference Host", "Funding Orgs", "Funding Text", "Cited References", "ISBN",
                "Supplement", "Early Access Date", "...68", "Journal Abbreviation", 
                "Journal ISO Abbreviation", "WoS Categories", "Research Areas")
drop_identifiers = c("Email Addresses", "Researcher Ids", "ORCIDs", "ISSN", 
                     "eISSN", "IDS Number", "UT (Unique WOS ID)", "Pubmed Id")
drop_nuances = c("Cited Reference Count", "Times Cited, WoS Core", 
                 "180 Day Usage Count", "Highly Cited Status", "Hot Paper Status")

dWCUSA = dataWCUSA %>%
  select(-remove_cols) %>%
  select(-drop_identifiers) %>%
  select(-drop_nuances)

dTS9J2 = dataTS9J2 %>%
  select(-remove_cols) %>%
  select(-drop_identifiers) %>%
  select(-drop_nuances)

dBAJ2 = dataBAJ2 %>%
  select(-remove_cols) %>%
  select(-drop_identifiers) %>%
  select(-drop_nuances)

remove_cols = c("Corporate Authors","Editors","Book Editors","Supplement",
                "Special Issue","Conference Title","Conference Date")

cWCUSA = citesWCUSA %>%
  select(-remove_cols)

cTS9J2 = citesTS9J2 %>%
  select(-remove_cols)

cBAJ2 = citesBAJ2 %>%
  select(-remove_cols)

# 3) Clean inconsistent data entries

cWCUSA$`Publication Year` = as.numeric(cWCUSA$`Publication Year`)
cTS9J2$`Publication Year` = as.numeric(cTS9J2$`Publication Year`)
cBAJ2$`Publication Year` = as.numeric(cBAJ2$`Publication Year`)

# 4) Order the data by year and article title 

doWCUSA = dWCUSA[order(-dWCUSA$`Publication Year`, dWCUSA$`Article Title`),]
coWCUSA = cWCUSA[order(-cWCUSA$`Publication Year`, cWCUSA$Title),]

doTS9J2 = dTS9J2[order(-dTS9J2$`Publication Year`, dTS9J2$`Article Title`),]
coTS9J2 = cTS9J2[order(-cTS9J2$`Publication Year`, cTS9J2$Title),]

doBAJ2 = dBAJ2[order(-dBAJ2$`Publication Year`, dBAJ2$`Article Title`),]
coBAJ2 = cBAJ2[order(-cBAJ2$`Publication Year`, cBAJ2$Title),]








# http://www.r-bloggers.com/bashr-howto-pass-parameters-from-bash-script-to-r/
# test passing parameters to R from a shell script

args <- commandArgs()
print(args)

name <- args[6]
  
require(lubridate)

write.table(iris,paste0(name), append = FALSE, quote = FALSE, sep = ",",
            eol = "n", na = "NA", dec = ".", row.names = FALSE,
            col.names = FALSE, qmethod = c("escape", "double"),
            fileEncoding = "")
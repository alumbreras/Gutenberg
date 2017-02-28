# Measure the sentence lengths of many books in Gutenberg
# Note: use nltk to get corpus from languages other than english
# http://www.nltk.org/book/ch02.html
#########################################################
library(gutenbergr)
library(data.table)
library(ggplot2)

# Download the data and create the dataframe with the counts
############################################################
df <- data.frame(matrix(nrow=0, ncol = 5))
colnames(df) <- c("title", "author", "language", "mean", "sd")
for (i in 1:100){
	book <- gutenberg_download(i, meta_fields = c('title', 'author', 'language'))
	text <- paste(tail(book$text,1000), collapse = " ")
	sentences <- strsplit(text, "[.]")
	lengths <- vapply(strsplit(sentences[[1]], "\\W+"), length, integer(1))
	mean_length <- mean(lengths)
	sd_length <- sd(lengths)
	df <- rbindlist(list(df, data.table(title = book$title[1], 
	                        author = book$author[1], 
	                        language = book$language[1], 
	                        mean_length = mean_length, 
	                        sd_length = sd_length)))
}

# Plot
###########################################################
df_filtered <- df %>% filter(mean<30)
ggplot(df_filtered, aes(x = title, y = mean)) + geom_point() + theme_bw()

library(gutenbergr)

df <- data.frame(title =  character(), author = character(),  language= character(), mean= numeric(), sd= numeric())

for (i in 1:100){
	book <- gutenberg_download(i, meta_fields = c('title', 'author', 'language'))
	text <- paste(tail(book$text,1000), collapse = " ")
	sentences <- strsplit(text, "[.]")
	lengths <- vapply(strsplit(sentences[[1]], "\\W+"), length, integer(1))
	mean_length <- mean(lengths)
	sd_length <- sd(lengths)
	df$title <- book$title[1]
	df$author <- book$author[1]
	df$language <- book$language[1]
	rbind(df, c(df$title, df$author, df$language, mean_length, sd_length))
}

require(data.table)
library(ggplot2)
#library(dplyr)

make_graph <- function(name, xax=T, yax=T, leg=T, asp_ratio=0.8) {
	lgs1<-as.data.frame(fread(paste(name, ".tsv", sep="")))
	print(lgs1)

	types = c("Nouns", "Proper Nouns", "Verbs", "Adjectives", "Other")
	allLgs = c("tat", "sah", "kaz", "tur", "kir", "crh", "tyv",
		"chv","uzb","bak","kaa","uig","krc","gag","kum",
		"aze","tki","tuk","nog","kjh","alt","ota")

	lgs1_new <- data.frame(language=factor(levels=allLgs), type=factor(levels=rev(types)), value=integer(),stringsAsFactors=FALSE)
	#print(lgs1_new)

	for (lg in lgs1$language) {
		for (type in types) {
			#print(lgs1[[type]])
			value = lgs1[[type]][lgs1$language==lg]
			#new_row = c(lg,type,value)
			new_row = list(language=c(lg),type=type,value=value)
			lgs1_new[nrow(lgs1_new) + 1,] <- new_row
		}
	}
	warnings()
	print(lgs1_new)

	#lgs1_new <- lgs1_new %>% arrange(n)
	
	#lgs1_new$type <- as.character(lgs1_new$type)
	#lgs1_new$type <- factor(lgs1_new$type, levels=types)
	
	aspect_ratio <- asp_ratio
	height <- 4

	if (yax) {
		yaxTh <- theme(axis.title.y=element_text(size=rel(1.4)))
	} else {
		yaxTh <- theme(axis.title.y=element_blank())
	}
	if (xax) {
		xaxTh <- theme(axis.title.x=element_text(size=rel(1.4)))
	} else {
		xaxTh <- theme(axis.title.x=element_blank())
	}
	if (leg) {
		legTh <- theme(legend.position = c(0.6, 0.75))
	} else {
		legTh <- theme(legend.position = "none")
	}

	p<-ggplot(data=lgs1_new)+ aes(fill=type,x=language,y=value/1000) +#, aes(fill=types))+
		geom_bar(position="stack", stat="identity") +
		labs(y="stems (×1000)",fill="category") +
		legTh +
		theme(axis.text.x=element_text(size=rel(1.5)),axis.text.y=element_text(size=rel(1.5))) +
		xaxTh + yaxTh

	ggsave(paste(name, ".pdf", sep=""), device="pdf", height = height, width = height * aspect_ratio)
}

make_graph("lgs1", F, T, F, 0.8)
make_graph("lgs2", F, F, F, 0.9)
make_graph("lgs3", F, F, T, 0.8)

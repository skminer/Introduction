### 1. read.table
data <- read.table("/Users/Sodami/Documents/OneDrive/R_Lecture/slack_assignments/Cars93.txt", 
                   header=T, sep="\t")
str(data)
dim(data)
t(names(data))
class(t(colnames(data)))
head(data)


### 2. subset
data.sub <- subset(data,
  Origin=="USA" & !is.na(Luggage.room),
  c("Make","Price","Length","Width","Weight"))
dim(data.sub)
names(data.sub)
head(data.sub)

### 3. function
mm <- function(x) {
  round(c(mean=mean(x),median=median(x)),3)
}
mm
mm(data.sub$Length)

### 4. apply
result <- apply(data.sub[-1],2,mm)
result <- sapply(data.sub[-1],mm)
result2 <- lapply(data.sub[-1],mm)
class(result)
str(result2)
result
result2[1][1]
unlist(result2)[1]
result


### 5. write.table
write.table(result,"Cars93_mm.txt",
            sep="\t",quote=F,row.names=F,na="")


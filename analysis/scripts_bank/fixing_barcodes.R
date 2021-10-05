# This routine searches for an index match, then greps for the barcode within and looks for a single match, then allows 1 base wrong for single match, then 2 wrong for single match, then trims first 2 bases and does it all again. Gets 97% of reads correct.

#a <- a[complete.cases(a),]

#a <- a[!is.na(a),]

#a <- incompletes[,1:3]

#grep('GTTGC', id_key$index)

#if grep in barcodes ==1 
#relpace 
#e
#elif agrep in barcodes 1
#thebn replace 
#elif agrep 3 in id then rereplace(

#no_index <- a[a$index %in% id_key$index,]
#incompletes <- incompletes[order(incompletes$count, decreasing = TRUE),]

incompletes <- incompletes[order(incompletes$count, decreasing = TRUE),]

a <- head(incompletes, n=10000)
sum(a$index %in% id_key$index)
sum(a[a$index %in% id_key$index,]$count)
sum(a[a$index %in% id_key$index,]$count) / sum(a$count)

for (i in 1:dim(a)[1]){
#      print(i)
      if (!a[i,]$index %in% id_key$index){
#            print('nonmatch')
#            print(a[i,]$index)
            match <- agrep(a[i,]$index, id_key$index, max.distance = 0)
#           print(paste(a[i,]$index, id_key[match,]$index))
            if (length(match) > 1){
                  match
#                  print('too many') 
                  }
            if (length(match)==1){
#                  print('one match')
                  a[i,]$index <- (id_key[match,]$index)
#                  print('written')
            }
            if (length(match) == 0){
#                  print('no matches')
                  match_a1 <- agrep(a[i,]$index, id_key$index, max.distance = 1)
#                  print(match_a1)
                  if (length(match_a1) > 1){
#                        print('too many')
                  }
                  if (length(match_a1) == 1) {
#                        print('got an a1 match')
#                        print(paste(a[i,]$index, id_key[match_a1,]$index))
                        a[i,]$index <- (id_key[match_a1,]$index)
#                        print('written a1')
                  }
                  if (length(match_a1) == 0) {
#                        print('going for a2')
                        match_a2 <- agrep(a[i,]$index, id_key$index, max.distance = 2)
#                        print(match_a2)
                        if (length(match_a2) == 1){
#                              print('got an a2 match')
#                              print(paste(a[i,]$index, id_key[match_a2,]$index))
                              a[i,]$index <- (id_key[match_a2,]$index)
#                              print('written a2')
                        }
                  }
                  else{
#                        print('no a1 there')
                  }
            }# is match 1?
      }
      else{
#            print('matched key')
            }
      # is index in key?
} # Forloop

# Cut the front off a few
for (i in 1:dim(a)[1]){
      #      print(i)
      if (!a[i,]$index %in% id_key$index){
            a[i,]$index <- substr(a[i,]$index, 3, 9)

      }
}
for (i in 1:dim(a)[1]){
      #      print(i)
      if (!a[i,]$index %in% id_key$index){
            #            print('nonmatch')
            #            print(a[i,]$index)
            match <- grep(a[i,]$index, id_key$index)
            #           print(paste(a[i,]$index, id_key[match,]$index))
            if (length(match) > 1){
                  match
                  #                  print('too many') 
            }
            if (length(match)==1){
                  #                  print('one match')
                  a[i,]$index <- (id_key[match,]$index)
                  #                  print('written')
            }
            if (length(match) == 0){
                  #                  print('no matches')
                  match_a1 <- agrep(a[i,]$index, id_key$index, max.distance = 1)
                  #                  print(match_a1)
                  if (length(match_a1) > 1){
                        #                        print('too many')
                  }
                  if (length(match_a1) == 1) {
                        #                        print('got an a1 match')
                        #                        print(paste(a[i,]$index, id_key[match_a1,]$index))
                        a[i,]$index <- (id_key[match_a1,]$index)
                        #                        print('written a1')
                  }
                  if (length(match_a1) == 0) {
                        #                        print('going for a2')
                        match_a2 <- agrep(a[i,]$index, id_key$index, max.distance = 2)
                        #                        print(match_a2)
                        if (length(match_a2) == 1){
                              #                              print('got an a2 match')
                              #                              print(paste(a[i,]$index, id_key[match_a2,]$index))
                              a[i,]$index <- (id_key[match_a2,]$index)
                              #                              print('written a2')
                        }
                  }
                  else{
                        #                        print('no a1 there')
                  }
            }# is match 1?
      }
      else{
            #            print('matched key')
      }
      # is index in key?
} # Forloop

sum(a$index %in% id_key$index)
sum(a[a$index %in% id_key$index,]$count) / sum(a$count)

#a[!a$index %in% id_key$index,]

#dim(incompletes)


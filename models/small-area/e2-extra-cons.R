# e2 - for etsim iteration 2, and beyond
weights[,,5] <- weights[,,5] * weights[,,4] * weights[,,3] * weights[,,2] * weights[,,1] 
ind.agg[,,1] <- ind.agg[,,5]

# re-weighting for constraint 1 via IPF 
for (j in 1:nrow(all.msim)){
  for(i in 1:ncol(con1)){
    weights[which(ind.cat[,i] == 1),j,1] <- con1[j,i] / ind.agg[j,i,1]}}

# convert con1 weights back into aggregates
for (i in 1:nrow(all.msim)){
  ind.agg[i,,2]   <- colSums(ind.cat * weights[,i,5] * weights[,i,1])}

# test results for first row
ind.agg[1,1:ncol(con1),2] - all.msim[1,1:ncol(con1)]

# second constraint
for (j in 1:nrow(all.msim)){
  for(i in 1:ncol(con2) + ncol(con1)){
    weights[which(ind.cat[,i] == 1),j,2] <- all.msim[j,i] /ind.agg[j,i,2]}}  

# convert con2 back into aggregate
for (i in 1:nrow(all.msim)){
  ind.agg[i,,3]   <- colSums(ind.cat * weights[,i,5] * weights[,i,1] *
                               weights[,i,2])}
# test results for first row
ind.agg[5,ncol(con1)+1:ncol(con2),3] 
all.msim[5,ncol(con1)+1:ncol(con2)]

# third constraint
for (j in 1:nrow(all.msim)){
  for(i in 1:ncol(con3) + ncol(con1) + ncol(con2)){
    weights[which(ind.cat[,i] == 1),j,3] <- all.msim[j,i] /ind.agg[j,i,3]}}

# convert con3 back into aggregate
for (i in 1:nrow(all.msim)){
  ind.agg[i,,4]   <- colSums(ind.cat * weights[,i,5] * weights[,i,1] * weights[,i,2] * 
                               weights[,i,3])}

# fourth constraint
for (j in 1:nrow(all.msim)) {
  for (i in 1:ncol(con4) + ncol(con1) + ncol(con2) + ncol(con3)) {
    weights[which(ind.cat[, i] == 1), j, 4] <- all.msim[j, i]/ind.agg[j, i, 4]
  }
}
for (i in 1:nrow(all.msim)) {
  ind.agg[i, , num.cons + 1] <- colSums(ind.cat * weights[, i, num.cons + 1] * 
      weights[, i, 1] * weights[, i, 2] * weights[, i, 3] * weights[, i, 4])
}
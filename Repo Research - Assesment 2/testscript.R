for (i in 1:nrow(t)){
if(t$CROPDMGEXP[i] == "K"){
  t$CROPDMGEXP[i] = 1000
} else if(t$CROPDMGEXP[i] == "M"){
  t$CROPDMGEXP[i] = 100000
} else if(t$CROPDMGEXP[i] == "B"){
  t$CROPDMGEXP[i] = 100000000
} else {
  t$CROPDMGEXP[i] = NA
}
}

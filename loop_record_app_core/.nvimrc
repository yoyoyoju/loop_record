let base = getcwd()
let mysrc = base . "/lib/**"
let mytest = base . "/test/**"
let &path = &path . "," . mysrc
let &path = &path . "," . mytest

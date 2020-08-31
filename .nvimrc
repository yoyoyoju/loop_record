let base = getcwd()
let mysrc = base . "/lib/**"
let &path = &path . "," . mysrc

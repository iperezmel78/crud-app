If (!$args[0]) {
  Write-Host "A message is needed"
} else {
  git status
  git add -A
  git commit -m $args[0]
  git push origin master
}
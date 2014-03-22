task :default => :web

desc "Compile pl0.pegjs browser version"
task :web do
  sh "pegjs -e pl0 views/pl0.pegjs public/pl0.js"
end

desc "Remove pl0.pegjs"
task :clean do
  sh "rm -f public/pl0.js"
end

desc "Compile pl0.pegjs browser version"
task :sass do
  sh "sass  public/styles.scss public/styles.css"
end

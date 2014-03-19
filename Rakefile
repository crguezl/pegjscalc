PEGJS = "pegjs"
task :default => :web

desc "Compile arithmetics.pegjs browser version"
task :web do
  sh "#{PEGJS} -e calculator arithmetics.pegjs"
end

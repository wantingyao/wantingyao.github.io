# check_encoding.rb
require 'find'

dirs_to_check = ["_posts", "_layouts", "_includes", "_pages"]
file_extensions = [".md", ".markdown", ".html", ".liquid"]

dirs_to_check.each do |dir|
  Find.find(dir) do |path|
    next unless file_extensions.any? { |ext| path.end_with?(ext) }
    begin
      File.open(path, "r:bom|utf-8") { |f| f.read }
    rescue Exception => e
      puts "⚠️  Wrong encoding: #{path}"
      puts "    Error message #{e.message}"
    end
  end
end

puts "check finished"
=begin
https://tinify.com/dashboard/api
API KEY: KQRNpRPpBS4HtmsGtfZ0ZCM7MPbnl1BG

⚠️使用时需要指定要压缩的文件夹，使用方法如下
cd [当前文件夹]
ruby tinypng.rb

⚠️压缩后会覆盖原有的图片
⚠️压缩失败的图片会保存在ARGV[0]_Failure文件夹下
=end

require 'fileutils'
require 'tinify'

$tinify_key = "KQRNpRPpBS4HtmsGtfZ0ZCM7MPbnl1BG"
Tinify.key = $tinify_key

$tinypng_file_path = `pwd`.chomp + "/images"
$tinypng_failure_path = `pwd`.chomp + "/images_Failure"

# 创建一个保存压缩失败图片的文件夹
def createFilurePath
  if !File.directory? $tinypng_failure_path
    Dir.mkdir $tinypng_failure_path
  end
end

# 调用tinypng的API进行图片压缩
def tinify(imgPath, imgName)
  puts "#{imgName}开始压缩"

  begin
    source = Tinify.from_file imgPath
    source.to_file imgPath
  rescue
    createFilurePath
    copyPath = $tinypng_failure_path + "/" + imgName
    FileUtils.cp imgPath, copyPath
    puts "#{imgName}压缩失败 #{$!}"
  end
end

def tinifyImage(path)
  Dir.foreach path do |entry|
    if entry == "." || entry == ".." || entry == ".DS_Store" #如果是这三个文件直接跳过
      next
    end

    p = "#{path}/#{entry}" #文件的路径
    if File.file? p
      if (p.end_with? ".png") || (p.end_with? ".PNG") || (p.end_with? ".jpg") || (p.end_with? ".JPEG")  #tinify只能压缩png和jpg格式的图片
        tinify p, entry
      end
    end
  end
end

if $tinypng_file_path
  tinifyImage $tinypng_file_path
else
  puts "请指定文件夹"
end
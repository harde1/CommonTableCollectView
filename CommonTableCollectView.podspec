Pod::Spec.new do |s|
  s.name         = "CommonTableCollectView"
  s.version      = "0.0.5"
  s.summary      = "General tableView, greatly reduce the programming workload"

  s.description  = "Program quickly,
The tableView object is encapsulated，How many groups of how many lines are what cell, all concentrated in a code inside, in fact, as long as you tell tableView, what data, what type of cell, it is enough"

  s.homepage     = "https://github.com/harde1/CommonTableCollectView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.source       = { :git => "https://github.com/harde1/CommonTableCollectView.git", :tag => s.version.to_s }
  s.author       = { "剑仁不败" => "harde1@163.com","敏钦" => "799621181@qq.com" }

  s.source_files  = "CommonTableCollectView/*.{h,m}"
  s.platform     = :ios, '7.1'
  s.requires_arc = true
end

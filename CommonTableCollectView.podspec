Pod::Spec.new do |s|
  s.name         = "CommonTableCollectView"
  s.version      = "0.0.1"
  s.summary      = "General tableView, greatly reduce the programming workload"

  s.description  = "对tableView进行了封装，多少组多少行有多高是什么cell,全部浓缩在一句代码里面，其实只要告诉tableView，是什么数据，对应什么类型的cell，就够了"

  s.homepage     = "https://github.com/harde1/CommonTableCollectView"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }

  s.source       = { :git => "https://github.com/harde1/CommonTableCollectView.git", :tag => s.version.to_s }
  s.author             = { "剑仁不败" => "harde1@163.com","敏钦" => "799621181@qq.com" }

  s.source_files  = "CommonTableCollectView/*.{h,m}"
  s.platform     = :ios, '7.1'
  s.requires_arc = true
end

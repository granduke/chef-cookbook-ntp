#
# Cookbook Name:: ntp
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
when "ubuntu","debian"
  package "ntpdate" do
    action :install
  end
end

package "ntp" do
  action [:install]
end

template "/etc/default/ntpdate" do
  source "ntpdate.default.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[ntp]"
end

template "/etc/ntp.conf" do
  source "ntp.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[ntp]"
end

service "ntp" do
  service_name node[:ntp][:service]
  action [:enable, :start]
end

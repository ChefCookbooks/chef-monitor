#
# Cookbook Name:: monitor
# Recipe:: mailer_handler
#
# Copyright 2013, PureDiscovery
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

template "/etc/sensu/conf.d/mailer.json" do
  source "mailer.json.erb"
  mode 0644
  variables({
    :mail_from => node["monitor"]["mailer"]["mail_from"],
    :mail_to => node["monitor"]["mailer"]["mail_to"],
    :smtp_address => node["monitor"]["mailer"]["smtp_address"],
    :smtp_port => node["monitor"]["mailer"]["smtp_port"],
    :smtp_domain => node["monitor"]["mailer"]["smtp_domain"]
  })
end

cookbook_file "/etc/sensu/handlers/mailer.rb" do
  source "handlers/mailer.rb"
  mode 0755
end

sensu_handler "mailer" do
  type "pipe"
  command "/etc/sensu/handlers/mailer.rb"
end

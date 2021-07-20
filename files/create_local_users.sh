#!/bin/bash

es_endpoint="https://${aws_es_endpoint}"
es_user="${master_user_name}"
es_pass="${master_user_password}"

create_users(){
  user_list=( ${local_users} )
  for user in $${user_list[@]};
  do 
   echo -e "\ncreating user $user"
   curl -XPUT -u $es_user:$es_pass $es_endpoint/_opendistro/_security/api/user/$user -d '{ "password" : "" , "backend_roles": ["all_access"]}' -H 'Content-Type: application/json'
  done
}

update_roles(){
  echo -e "\nadding user to roles"
  curl -XPUT -u $es_user:$es_pass $es_endpoint/_opendistro/_security/api/rolesmapping/all_access -d '  { "users": [ "master", "logstash", "proxy" ] }' -H 'Content-Type: application/json' 
}

create_users
update_roles

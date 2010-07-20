# encoding: UTF-8
# Source Code Modifications (c) 2010 Laurence A. Lee, 
# See /RUBYJEDI.txt for Licensing and Distribution Terms
# THIS CLASS IS OBSOLETE.
#
# Only keeping it here to support migration #11 for the time being.
#
class ContentNodeType < ActiveRecord::Base
  has_many :content_nodes
end

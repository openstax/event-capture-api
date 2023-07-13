
record :Attachment, namespace: 'org.adlnet.xapi' do
  required :usageType, :string
  required :display, :map, values: :string
  required :description, :map, values: :string
  required :contentType, :string
  required :length, :int
  required :sha2, :string
  optional :fileUrl, :string

  doc 'Attachment schema'
end

record :ActivityDefinition, namespace: 'org.adlnet.xapi' do
  optional :name, :map, values: :string
  optional :description, :map, values: :string
  optional :type, :string
  optional :moreInfo, :string
  optional :extensions, :map, values: :string

  doc 'ActivityDefinition schema'
end

record :Activity, namespace: 'org.adlnet.xapi' do
  required :id, :string
  required :objectType, :string
  optional :definition, :ActivityDefinition

  doc 'Activity schema'
end

record :Score, namespace: 'org.adlnet.xapi' do
  optional :scaled, :double
  optional :raw, :double
  optional :min, :double
  optional :max, :double

  doc 'Score schema'
end

record :ContextActivities, namespace: 'org.adlnet.xapi' do
  optional :parent, :array, items: :Activity
  optional :category, :array, items: :Activity
  optional :other, :array, items: :Activity

  doc 'ContextActivities schema'
end

record :Account, namespace: 'org.adlnet.xapi' do
  required :homePage, :string
  required :name, :string

  doc 'Account schema'
end

record :Agent, namespace: 'org.adlnet.xapi' do
  required :objectType, :string
  optional :name, :string
  optional :mbox, :string
  optional :mbox_sha1sum, :string
  optional :openid, :string
  optional :account, :Account

  doc 'Agent schema'
end

record :Group, namespace: 'org.adlnet.xapi' do
  required :objectType, :string
  optional :name, :string
  optional :member, :array, items: :Agent

  doc 'Group schema'
end

record :Verb, namespace: 'org.adlnet.xapi' do
  required :id, :string
  optional :display, :map, values: :string

  doc 'Verb schema'
end

record :Result, namespace: 'org.adlnet.xapi' do
  optional :score, :Score
  optional :success, :boolean
  optional :completion, :boolean
  optional :response, :string
  optional :duration, :string
  optional :extensions, :map, values: :string

  doc 'Result schema'
end

record :StatementReference, namespace: 'org.adlnet.xapi' do
  required :objectType, :string
  required :id, :string

  doc 'StatementReference schema'
end

record :Context, namespace: 'org.adlnet.xapi' do
  optional :registration, :string
  optional :instructor, :union, types: [:Agent, :Group]
  optional :team, :Group
  optional :contextActivities, :ContextActivities
  optional :revision, :string
  optional :platform, :string
  optional :language, :string
  optional :statement, :StatementReference
  optional :extensions, :map, values: :string

  doc 'Context schema'
end

record :Statement, namespace: 'org.adlnet.xapi' do
  required :id, :string
  required :actor, :union, types: [:Agent, :Group]
  required :verb, :Verb
  required :object, :union, types: [:Activity, :Agent, :Statement]
  optional :result, :Result
  optional :context, :Context
  optional :timestamp, :string
  optional :stored, :string
  optional :authority, :Agent
  optional :version, :string
  optional :attachments, :array, items: :Attachment

  doc 'Experience API (xAPI) Statement schema'
end

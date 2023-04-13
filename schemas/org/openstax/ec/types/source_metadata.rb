record :source_metadata do
  required :content_id, :uuid
  required :content_version, :string
  optional :context_version, :string
  optional :content_index, :int
  optional :scope_id, :uuid
end

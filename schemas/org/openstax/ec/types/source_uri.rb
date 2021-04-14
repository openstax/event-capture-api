record :source_uri do
  required :scheme, :string
  required :host, :string
  required :path, :string
  optional :query, :map, values: array(:string)
end

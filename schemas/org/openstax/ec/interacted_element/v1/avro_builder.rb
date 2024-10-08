namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'
import 'types/base_web_event'
import 'types/source_metadata'

record :interacted_element_v1 do
  extends :base_web_event
  required :target_id, :string
  required :target_type, :string
  required :target_attributes, :map, values: :string
  optional :target_state_change, :string
  required :context_id, :string
  required :context_type, :string
  required :context_attributes, :map, values: :string
  required :occurred_at, :timestamp
  optional :context_region, :string
  optional :context_state_change, :string
  optional :source_metadata, :source_metadata
end

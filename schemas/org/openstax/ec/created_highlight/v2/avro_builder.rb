namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'
import 'types/base_web_event'
import 'types/source_metadata'

record :created_highlight_v2 do
  extends :base_web_event
  required :highlight_id, :string
  required :source_type, :string
  required :source_metadata, :map, values: :string
  required :anchor, :string
  required :color, :string
  required :location_strategies, :string
  required :occurred_at, :timestamp
  optional :source_metadata, :source_metadata
end

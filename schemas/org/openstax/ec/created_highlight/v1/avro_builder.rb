namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'
import 'types/base_web_event'

record :created_highlight_v1 do
  extends :base_web_event
  required :highlight_id, :string
  required :source_type, :string
  required :source_id, :string
  required :source_metadata, :string
  required :annotation, :string
  required :anchor, :string
  required :color, :string
  required :location_strategies, :string
  required :scope_id, :string
  required :occurred_at, :timestamp
end

namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'

record :created_highlight_v1 do
  required :user_uuid, :uuid
  required :highlights_id, :string
  required :source_type, :string
  required :source_id, :string
  required :source_metadata, :string
  required :annotation, :string
  required :anchor, :string
  required :color, :string
  required :location_strategies, :string
  required :scope_id, :string
  required :occurred_at, :timestamp
  required :session_uuid, :string
  required :session_order, :int
end

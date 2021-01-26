namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'
import 'types/who_am_i'
import 'types/ordered_session'
import 'types/source_uri'

record :created_highlight_v1 do
  extends :who_am_i
  extends :ordered_session
  extends :source_uri
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

module RegisteredApplicationsHelper
  def event_summary(events)
    acc = {}
    events.each { |e| acc[e.name] ? acc[e.name] += 1 : acc[e.name] = 1 }
    acc
  end
end

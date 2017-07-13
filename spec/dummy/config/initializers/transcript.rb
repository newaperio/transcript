Transcript.configure do |config|
  config.audit_model = AuditEntry
  config.create_mode = :asynchronous
end

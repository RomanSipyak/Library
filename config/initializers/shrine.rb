require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/s3"

if Rails.env.production?
  s3_options = {
    bucket: Rails.application.credentials.production[:aws][:bucket],
    access_key_id: Rails.application.credentials.production[:aws][:access_key_id],
    secret_access_key: Rails.application.credentials.production[:aws][:secret_access_key],
    region: Rails.application.credentials.production[:aws][:s3_region],
  }

  Shrine.storages = {
      cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options), # temporary
      store: Shrine::Storage::S3.new(**s3_options), # permanent
  }
else
  Shrine.storages = {
      cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
      store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),       # permanent
  }
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :determine_mime_type

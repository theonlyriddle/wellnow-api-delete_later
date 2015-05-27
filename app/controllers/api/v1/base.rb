require "grape-swagger"

module API
  module V1
    class Base < Grape::API
      mount API::V1::Contacts
      mount API::V1::Doctors
      mount API::V1::Categories
      mount API::V1::Languages
      mount API::V1::Searches
      mount API::V1::Availabilities
      mount API::V1::Capacities
      mount API::V1::Slots
      mount API::V1::Sessions
      mount API::V1::Users
      mount API::V1::Bookings

      # mount API::V1::AnotherResource

      add_swagger_documentation(
        api_version: "v1",
        hide_documentation_path: true,
        mount_path: "/api/v1/swagger_doc",
        hide_format: true
      )
    end
  end
end

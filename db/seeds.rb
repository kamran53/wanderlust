# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
puts "Clearing existing data..."
Client.destroy_all
ProjectManager.destroy_all
VideoType.destroy_all
Project.destroy_all
Video.destroy_all
Notification.destroy_all

# Create Video Types
puts "Creating video types..."
video_types = [
  { name: "Highlight Reel", description: "A compilation of the best moments from your footage", price: 15000 },
  { name: "Full Documentary", description: "Complete documentary-style edit with narrative structure", price: 25000 },
  { name: "Teaser", description: "Short promotional video to generate interest", price: 8000 },
  { name: "Social Media Clip", description: "Optimized for social media platforms", price: 5000 },
  { name: "Corporate Video", description: "Professional business presentation", price: 20000 }
]

video_types.each do |vt|
  VideoType.create!(vt)
end

# Create Project Managers
puts "Creating project managers..."
project_managers = [
  { name: "Sarah Johnson", email: "sarah.johnson@wanderlust.com" },
  { name: "Mike Chen", email: "mike.chen@wanderlust.com" },
  { name: "Emily Rodriguez", email: "emily.rodriguez@wanderlust.com" }
]

project_managers.each do |pm|
  ProjectManager.create!(pm)
end

# Create Clients
puts "Creating clients..."
clients = [
  { name: "John Smith", email: "john.smith@example.com" },
  { name: "Jane Doe", email: "jane.doe@example.com" },
  { name: "Bob Wilson", email: "bob.wilson@example.com" }
]

clients.each do |client|
  Client.create!(client)
end

# Create Projects with Videos
puts "Creating projects and videos..."
clients = Client.all
project_managers = ProjectManager.all
video_types = VideoType.all

clients.each_with_index do |client, index|
  pm = project_managers[index % project_managers.length]
  
  project = Project.create!(
    name: "#{client.name}'s Project #{index + 1}",
    status: ['pending', 'in_progress', 'completed'].sample,
    raw_footage_link: "https://drive.google.com/folderview?id=sample#{index}",
    client: client,
    project_manager: pm
  )
  
  # Add 1-3 videos to each project
  rand(1..3).times do
    video_type = video_types.sample
    Video.create!(
      project: project,
      video_type: video_type
    )
  end
  
  # Create notification for PM
  Notification.create!(
    message: "New project '#{project.name}' has been assigned to you",
    project_manager: pm,
    project: project
  )
end

puts "Seed data created successfully!"
puts "Created #{VideoType.count} video types"
puts "Created #{ProjectManager.count} project managers"
puts "Created #{Client.count} clients"
puts "Created #{Project.count} projects"
puts "Created #{Video.count} videos"
puts "Created #{Notification.count} notifications"

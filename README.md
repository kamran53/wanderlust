# Wanderlust Videos

A Ruby 3 and Rails 7 application backed by MySQL DB for managing video editing projects. Clients can order different types of videos, and Project Managers are automatically assigned to oversee the projects.


## Features Implemented

### Models & Associations
- **Client**: Has many projects
- **Project**: Belongs to client and project manager, has many videos
- **ProjectManager**: Has many projects and notifications
- **VideoType**: Has many videos, with pricing information
- **Video**: Belongs to project and video type
- **Notification**: Belongs to project manager and project

### Client Views
1. **Project Index View** (`/`)
   - Shows list of client's existing projects
   - Displays project status, assigned PM, video types, and total price
   - Link to order new projects

2. **Order Project View** (`/projects/order_project`)
   - Video selection grid with prices
   - Project details form (name, raw footage link)
   - Interactive cart with real-time price calculation
   - Payment modal simulation
   - Background notification creation for PMs

### Technical Features
- **Optimized Queries**: Uses `includes` to prevent N+1 queries
- **Background Jobs**: Notifications are created asynchronously
- **Service Objects**: Business logic separated into `ProjectCreationService`
- **Responsive UI**: Bootstrap 5 for modern, mobile-friendly interface
- **Form Validation**: Client and server-side validation
- **Database Indexes**: Proper indexing for performance

## Setup Instructions

1. **Install Dependencies**
   ```bash
   bundle install
   ```

2. **Set Environment Variables**
  - Create a `.env` file at root directory to store ENVs

3. **Database Setup**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the Server**
   ```bash
   rails server
   ```

5. **Visit the Application**
   - Open http://localhost:3000
   - You'll see the project index for the first client
   - Click "Order New Project" to create a new project

## Database Schema

### Key Tables
- `clients`: Client information
- `project_managers`: PM information  
- `video_types`: Available video types with pricing
- `projects`: Project details and status
- `videos`: Links projects to video types
- `notifications`: PM notifications

### Important Fields
- Prices are stored in cents (integer) for precision
- Project status: pending, in_progress, completed, cancelled
- Notifications include read_at timestamp for tracking

## Business Logic

### Project Creation Flow
1. Client selects video types and provides project details
2. System creates project with "pending" status
3. Automatically assigns first available PM
4. Creates videos for each selected video type
5. Enqueues background job to create PM notification
6. Updates project status to "in_progress"
7. Redirects to project index

### Query Optimization
- Uses eager loading (`includes`) to prevent N+1 queries
- Database indexes on frequently queried fields
- Efficient joins for calculating project totals

## Testing

The application includes:
- Model validations
- Service object error handling
- Background job processing
- Form validation (client and server-side)

## Future Enhancements

- User authentication system
- PM load balancing algorithm
- Payment gateway integration
- File upload for raw footage
- Project status updates and notifications
- Admin dashboard for PMs
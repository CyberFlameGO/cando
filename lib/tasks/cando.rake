require 'tmpdir'
require_relative '../db'

CANDO_MIGRATION_DIR = "db/cando-migrations"
CANDO_SCHEMA = File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "contrib", "initial_schema.rb")

namespace :cando do
  desc "Initialize cando (creates schema and runs migration)"
  task :init do
    if Dir.glob("#{CANDO_MIGRATION_DIR}/*#{File.basename(CANDO_SCHEMA)}*").empty?
      puts green("Copying cando schema to local cando migrations folder '#{CANDO_MIGRATION_DIR}'")
      cando_schema_migration = File.join(CANDO_MIGRATION_DIR, "#{Time.now.strftime("%Y%m%d%H%M%S")}_#{File.basename(CANDO_SCHEMA)}")

      FileUtils.mkdir_p(CANDO_MIGRATION_DIR) unless File.exists?(CANDO_MIGRATION_DIR)
      FileUtils.cp(CANDO_SCHEMA, cando_schema_migration)
    else
      $stderr.puts red("skipping copying cando schema migration file: already exists")
    end

    Rake::Task['cando:migrate'].invoke

    puts <<EOF
    #{green("Success!")}

In order to add, update or remove a role, call

    rake cando:add    role=<rolename> capabilities=<cap1>,<cap2>,<cap3>
    rake cando:update role=<rolename> capabilities=<cap1>,<cap2>,<cap3>
    rake cando:remove role=<rolename>

When adding or updating a roles it doesn't matter whether the passed in capabilities
exist or not -- if not existant, they will be created automatically

For more cando rake tasks execute

    rake -T cando

EOF

  end

  desc "Migrate cando db"
  task :migrate, [:version] do |_, args|
    Sequel.extension :migration

    if version = args[:version]
      puts "Migrating to version #{version}"
      Sequel::Migrator.run(Cando.connect, CANDO_MIGRATION_DIR, { allow_missing_migration_files: true, target: version.to_i } )
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(Cando.connect, CANDO_MIGRATION_DIR, { allow_missing_migration_files: true} )
    end
  end

  desc "Add a new role (pass in role name and capabilities with role=<name> capabilities=<cap1>,<cap2>,... )"
  task :add do
    add_role(false)
  end

  desc "Update role (pass in role name and capabilities with role=<name> capabilities=<cap1>,<cap2>,... )"
  task :update do
    add_role(true)
  end


  desc "Remove role (pass in role name with role=<name>)"
  task :remove do
    unless ENV['role']
      $stderr.puts red("usage: rake cando:remove role=<rolename>")
      exit 1
    end

    unless r = CanDo::Role.find(:id => ENV['role'])
      $stderr.puts red("role '#{args.role}' does not exist")
      exit 1
    end

    r.destroy
  end

  desc "Assign role to user (args: roles=<r1>,<r2>,<rn> user=<user_urn>)"
  task :assign do
    roles = ENV['roles']
    user_urn  = ENV['user']

    unless roles && user_urn
      $stderr.puts red("usage: rake cando:assign user=<user_urn> roles=<role1>,<role2>,... ")
    end

    include CanDoHelper
    assign_roles(user_urn, roles.split(","))
  end

  desc "List roles"
  task :list do
    puts "ROLE\tCAPABILITIES"
    CanDo::Role.all.each do |role|
      puts role
    end
  end

  desc "List users and their roles"
  task :users do
    puts "USER_URN\tROLES"
    CanDo::User.all.each do |user|
      puts user
    end
  end

end

def green(text)
  "\033[1;32;48m#{text}\033[m"
end

def red(text)
  "\033[1;31;48m#{text}\033[m"
end

def add_role(force = false)
  role         = ENV['role']
  capabilities = ENV['capabilities'] && ENV['capabilities'].split(",")

  unless role && capabilities
    puts red("usage: rake cando:add    role=<rolename> capabilities=<cap1>,<cap2>,<cap3>")
    exit 1
  end

  if !force && CanDo::Role.find(:id => role)
    puts red("Role '#{role}' already exists!")
    puts "If you want to update '#{role}', please use 'rake cando:update'"
    exit 1
  end

  include CanDoHelper
  define_role(role, capabilities)
end

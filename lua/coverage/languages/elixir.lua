local M = {}

local Path = require("plenary.path")
local common = require("coverage.languages.common")
-- local config = require("coverage.config")
local util = require("coverage.util")
--- Loads a coverage report.
-- This method should perform whatever steps are necessary to generate a coverage report.
-- The coverage report results should passed to the callback, which will be cached by the plugin.
-- @param callback called with results of the coverage report
M.load = function(callback)
  local elixir_config = { coverage_file = "cover/lcov.info" }
  local p = Path:new(elixir_config.coverage_file)
  if not p:exists() then
    vim.notify("No coverage file exists.", vim.log.levels.INFO)
    return
  end

  callback(util.lcov_to_table(p))
end


--- Returns a list of signs that will be placed in buffers.
-- This method should use the coverage data (previously generated via the load method) to 
-- return a list of signs.
-- @return list of signs
M.sign_list = common.sign_list
-- M.sign_list = function(data)
--   -- TODO: generate a list of signs using:
--   -- require("coverage.signs").new_covered(bufnr, linenr)
--   -- require("coverage.signs").new_uncovered(bufnr, linenr)
-- end

M.summary = common.summary
--- Returns a summary report.
-- @return summary report
-- M.summary = function(data)
--   -- TODO: generate a summary report in the format
--   return {
--     files = {
--       { -- all fields, except filename, are optional - the report will be blank if the field is nil
--         filename = fname,            -- filename displayed in the report
--         statements = statements,     -- number of total statements in the file
--         missing = missing,           -- number of lines missing coverage (uncovered) in the file
--         excluded = excluded,         -- number of lines excluded from coverage reporting in the file
--         branches = branches,         -- number of total branches in the file
--         partial = partial_branches,  -- number of branches that are partially covered in the file
--         coverage = coverage,         -- coverage percentage (float) for this file
--       }
--     },
--     totals = { -- optional
--       statements = total_statements,     -- number of total statements in the report
--       missing = total_missing,           -- number of lines missing coverage (uncovered) in the report
--       excluded = total_excluded,         -- number of lines excluded from coverage reporting in the report
--       branches = total_branches,         -- number of total branches in the report
--       partial = total_partial_branches,  -- number of branches that are partially covered in the report
--       coverage = total_coverage,         -- coverage percentage to display in the report
--     }
--   }
-- end
        -- javascript = {
        --     coverage_file = "coverage/lcov.info",
        -- },
return M


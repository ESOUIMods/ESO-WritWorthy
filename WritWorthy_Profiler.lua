--[[
-------------------------------------------------------------------------------
-- WritWorthy
-------------------------------------------------------------------------------
-- Original author: ziggr (project started 2017-02-12)
--
-- Current maintainer: Sharlikran (contributions since 2022-11-12)
-- Contributor: jogietze (formerly otac0n) � GitHub PR contributions
--
-- ----------------------------------------------------------------------------
-- Unless otherwise stated, portions of this software are � ziggr and may
-- be subject to �All Rights Reserved� status due to the absence of a public
-- open-source license declaration.
--
-- ----------------------------------------------------------------------------
-- Contributions by Sharlikran are licensed under the BSD 3-Clause License:
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- 1. Redistributions of source code must retain the above copyright notice,
--    this list of conditions and the following disclaimer.
--
-- 2. Redistributions in binary form must reproduce the above copyright notice,
--    this list of conditions and the following disclaimer in the documentation
--    and/or other materials provided with the distribution.
--
-- 3. Neither the name of the author "Sharlikran" nor the names of previous
--    contributors may be used to endorse or promote products derived from this
--    software without specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES ARE DISCLAIMED. IN NO EVENT SHALL THE
-- COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING IN
-- ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
-- OF SUCH DAMAGE.
--
-- Maintainer Notice:
-- Redistribution of this software outside of ESOUI.com (including Bethesda.net
-- or other platforms) is discouraged unless authorized by the current
-- maintainer. Please do not redistribute or fork without attribution,
-- permission, and license compliance.
-------------------------------------------------------------------------------
]]
local WritWorthy = _G["WritWorthy"] -- defined in WritWorthy_Define.lua

WritWorthy.Profiler = { stats = {} }
local Profiler = WritWorthy.Profiler

local function time_ms()
  return GetGameTimeMilliseconds()
end

function Profiler.GetStats(func_name)
  if not Profiler.stats[func_name] then
    Profiler.stats[func_name] = {
      call_ct = 0,
      dur_ms = 0,
      start_ms = 0
    }
  end
  return Profiler.stats[func_name]
end

function Profiler.Call(func_name)
  if not Profiler.enabled then
    return
  end
  local s = Profiler.GetStats(func_name)
  s.call_ct = s.call_ct + 1
  s.start_ms = time_ms()
end

function Profiler.End(func_name)
  if not Profiler.enabled then
    return
  end
  local s = Profiler.GetStats(func_name)
  local dur_ms = time_ms() - s.start_ms
  s.dur_ms = s.dur_ms + dur_ms
  s.start_ms = nil
end

function Profiler.Start()
  Profiler.enabled = true
  WritWorthy.savedVariables.profiler_stats = Profiler.stats
  d("Profiler enabled")
end

function Profiler.Stop()
  Profiler.enabled = false
  d("Profiler disabled")
end
